@[Link(ldflags: "`mecab-config --libs`")]
lib LibMeCab
  type MeCab_T                 = Void
  type MeCab_Model_T           = Void
  type MeCab_Lattice_T         = Void

  # Parameters for MeCab_Dictionary_Info_T.type
  MECAB_SYS_DIC = 0
  MECAB_USR_DIC = 1
  MECAB_UNK_DIC = 2

  struct MeCab_Dictionary_Info_T
    filename : UInt8*
    charset  : UInt8*
    size     : UInt32
    type     : Int32
    lsize    : UInt32
    rsize    : UInt32
    version  : UInt16
    next     : MeCab_Dictionary_Info_T*
  end

  struct MeCab_Path_T
    rnode : MeCab_Node_T*
    rnext : MeCab_Path_T*
    lnode : MeCab_Node_T*
    lnext : MeCab_Path_T*
    cost  : Int32
    prob  : Float32
  end

  # Parameters for MeCab_Node_T.stat
  MECAB_NOR_NODE = 0
  MECAB_UNK_NODE = 1
  MECAB_BOS_NODE = 2
  MECAB_EOS_NODE = 3
  MECAB_EON_NODE = 4

  struct MeCab_Node_T
    prev      : MeCab_Node_T*
    next      : MeCab_Node_T*
    enext     : MeCab_Node_T*
    bnext     : MeCab_Node_T*
    rpath     : MeCab_Path_T*
    lpath     : MeCab_Path_T*
    surface   : UInt8*
    feature   : UInt8*
    id        : UInt32
    length    : UInt16
    rlength   : UInt16
    rcAttr    : UInt16
    lcAttr    : UInt16
    posid     : UInt16
    char_type : UInt8
    stat      : UInt8
    isbest    : UInt8
    alpha     : Float32
    beta      : Float32
    prob      : Float32
    wcost     : Int16
    cost      : Int64
  end

  # Parameters for lattice request_type
  MECAB_ONE_BEST         = 1
  MECAB_NBEST            = 2
  MECAB_PARTIAL          = 4
  MECAB_MARGINAL_PROB    = 8
  MECAB_ALTERNATIVE      = 16
  MECAB_ALL_MORPHS       = 32
  MECAB_ALLOCATE_SENTENC = 64

  # Parameters for lattice boundary_constraint_type
  MECAB_ANY_BOUNDARY   = 0
  MECAB_TOKEN_BOUNDARY = 1
  MECAB_INSIDE_TOKEN   = 2

  fun mecab_new(argc : Int32, argv : UInt8**) : MeCab_T*
  fun mecab_new2(arg : UInt8**) : MeCab_T*
  fun mecab_version() : UInt8*
  fun mecab_strerror(mecab : MeCab_T*) : UInt8*
  fun mecab_destroy(mecab : MeCab_T*) : Void

  fun mecab_get_partial(mecab : MeCab_T*) : Int32
  fun mecab_set_partial(mecab : MeCab_T*, partial : Int32) : Void
  fun mecab_get_theta(mecab : MeCab_T*) : Float32
  fun mecab_set_theta(mecab : MeCab_T*, theta : Float32) : Void
  fun mecab_get_lattice_level(mecab : MeCab_T*) : Int32
  fun mecab_set_lattice_level(mecab : MeCab_T*, level : Int32) : Void
  fun mecab_get_all_morphs(mecab : MeCab_T*) : Int32
  fun mecab_set_all_morphs(mecab : MeCab_T*, all_morphs : Int32) : Void

  fun mecab_parse_lattice(mecab : MeCab_T*, lattice : MeCab_Lattice_T*) : Int32
  fun mecab_sparse_tostr(mecab : MeCab_T*, str : UInt8*) : UInt8*
  fun mecab_sparse_tostr2(mecab : MeCab_T*, str : UInt8*, len : LibC::SizeT) : UInt8*
  fun mecab_sparse_tostr3(mecab : MeCab_T*, str : UInt8*, len : LibC::SizeT, ostr : UInt8*, olen : LibC::SizeT) : UInt8*
  fun mecab_sparse_tonode(mecab : MeCab_T*, str : UInt8*) : MeCab_Node_T*
  fun mecab_sparse_tonode2(mecab : MeCab_T*, str : UInt8*, len : LibC::SizeT) : MeCab_Node_T*

  fun mecab_nbest_sparse_tostr(mecab : MeCab_T*, n : LibC::SizeT, str : UInt8*) : UInt8*
  fun mecab_nbest_sparse_tostr2(mecab : MeCab_T*, n : LibC::SizeT, str : UInt8*, len : LibC::SizeT) : UInt8*
  fun mecab_nbest_sparse_tostr3(mecab : MeCab_T*, n : LibC::SizeT, str : UInt8*, len : LibC::SizeT, ostr : UInt8*, olen : LibC::SizeT) : UInt8*
  fun mecab_nbest_init(mecab : MeCab_T*, str : UInt8*) : Int32
  fun mecab_nbest_init2(mecab : MeCab_T*, str : UInt8*, len : LibC::SizeT) : Int32
  fun mecab_nbest_next_tostr(mecab : MeCab_T*) : UInt8*
  fun mecab_nbest_next_tostr2(mecab : MeCab_T*, ostr : UInt8*, olen : LibC::SizeT) : UInt8
  fun mecab_nbest_next_tonode(mecab : MeCab_T*) : MeCab_Node_T*

  fun mecab_format_node(mecab : MeCab_T*, node : MeCab_Node_T*) : UInt8*

  fun mecab_dictionary_info(mecab : MeCab_T*) : MeCab_Dictionary_Info_T*

  fun mecab_lattice_new() : MeCab_Lattice_T*
  fun mecab_lattice_destroy(lattice : MeCab_Lattice_T*) : Void
  fun mecab_lattice_clear(lattice : MeCab_Lattice_T*) : Void
  fun mecab_lattice_is_available(lattice : MeCab_Lattice_T*) : Int32
  fun mecab_lattice_strerror(lattice : MeCab_Lattice_T*) : UInt8*
  fun mecab_lattice_get_bos_node(lattice : MeCab_Lattice_T*) : MeCab_Node_T*
  fun mecab_lattice_get_eos_node(lattice : MeCab_Lattice_T*) : MeCab_Node_T*
  fun mecab_lattice_get_all_begin_nodes(lattice : MeCab_Lattice_T*) : MeCab_Node_T**
  fun mecab_lattice_get_all_end_nodes(lattice : MeCab_Lattice_T*) : MeCab_Node_T**
  fun mecab_lattice_get_begin_nodes(lattice : MeCab_Lattice_T*, pos : LibC::SizeT) : MeCab_Node_T*
  fun mecab_lattice_get_end_nodes(lattice : MeCab_Lattice_T*, pos : LibC::SizeT) : MeCab_Node_T*
  fun mecab_lattice_get_sentence(lattice : MeCab_Lattice_T*) : UInt32*
  fun mecab_lattice_set_sentence(lattice : MeCab_Lattice_T*, sentence : UInt8*) : Void
  fun mecab_lattice_set_sentence2(lattice : MeCab_Lattice_T*, sentence : UInt8*, len : LibC::SizeT) : Void
  fun mecab_lattice_get_size(lattice : MeCab_Lattice_T*) : Int32
  fun mecab_lattice_get_z(lattice : MeCab_Lattice_T*) : Float64
  fun mecab_lattice_set_z(lattice : MeCab_Lattice_T*, z : Float64) : Void
  fun mecab_lattice_get_theta(lattice : MeCab_Lattice_T*) : Float64
  fun mecab_lattice_set_theta(lattice : MeCab_Lattice_T*, theta : Float64) : Void
  fun mecab_lattice_next(lattice : MeCab_Lattice_T*) : Int32
  fun mecab_lattice_get_request_type(lattice : MeCab_Lattice_T*) : Int32
  fun mecab_lattice_has_request_type(lattice : MeCab_Lattice_T*, request_type : Int32) : Void
  fun mecab_lattice_set_request_type(lattice : MeCab_Lattice_T*, request_type : Int32) : Void
  fun mecab_lattice_add_request_type(lattice : MeCab_Lattice_T*, request_type : Int32) : Void
  fun mecab_lattice_remove_request_type(lattice : MeCab_Lattice_T*, request_type : Int32) : Void
  fun mecab_lattice_new_node(lattice : MeCab_Lattice_T*) : MeCab_Node_T*
  fun mecab_lattice_tostr(lattice : MeCab_Lattice_T*) : UInt8*
  fun mecab_lattice_tostr2(lattice : MeCab_Lattice_T*, buf : UInt8*, len : LibC::SizeT) : UInt8*
  fun mecab_lattice_nbest_tostr(lattice : MeCab_Lattice_T*, n : LibC::SizeT) : UInt8*
  fun mecab_lattice_nbest_tostr2(lattice : MeCab_Lattice_T*, n : LibC::SizeT, buf : UInt8*, len : LibC::SizeT) : UInt8*
  fun mecab_lattice_has_constraint(lattice : MeCab_Lattice_T*) : Int32
  fun mecab_lattice_get_boundary_constraint(lattice : MeCab_Lattice_T*, pos : LibC::SizeT) : Int32
  fun mecab_lattice_set_boundary_constraint(lattice : MeCab_Lattice_T*, pos : LibC::SizeT, boundary_type : Int32) : Void
  fun mecab_lattice_get_feature_constraint(lattice : MeCab_Lattice_T*, pos : LibC::SizeT) : UInt32*
  fun mecab_lattice_set_feature_constraint(lattice : MeCab_Lattice_T*, begin_pos : LibC::SizeT, end_pos : LibC::SizeT, feature : UInt8*) : Void
  fun mecab_lattice_set_result(lattice : MeCab_Lattice_T*, result : UInt8*) : Void
  fun mecab_lattice_strerror(lattice : MeCab_Lattice_T*) : UInt8*

  fun mecab_model_new(argc : Int32, argv : UInt8*) : MeCab_Model_T*
  fun mecab_model_new2(arg : UInt8*) : MeCab_Model_T*
  fun mecab_model_destroy(MeCab_Model_T*) : Void
  fun mecab_model_new_tagger(model : MeCab_Model_T*) : MeCab_T*
  fun mecab_model_new_lattice(model : MeCab_Model_T*) : MeCab_Lattice_T*
  fun mecab_model_swap(model : MeCab_Model_T*, new_model : MeCab_Model_T*)

  fun mecab_model_dictionary_info(model : MeCab_Model_T*) : MeCab_Dictionary_Info_T*
  fun mecab_model_transition_cost(model : MeCab_Model_T*, rcAttr : UInt16, lcAttr : UInt16) : Int32
  fun mecab_model_lookup(model : MeCab_Model_T*, begin : UInt8*, end : UInt8*, lattice : MeCab_Lattice_T*) : Int32
end
