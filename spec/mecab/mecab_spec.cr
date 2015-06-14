require "../spec_helper"

def ipadic()
  return `mecab-config --dicdir`.chomp() + "/ipadic"
end

def initialize_mecab(arg)
  model   = LibMeCab.mecab_model_new2("-d #{ipadic()} #{arg}")
  tagger  = LibMeCab.mecab_model_new_tagger(model)
  lattice = LibMeCab.mecab_model_new_lattice(model)

  return model, tagger, lattice
end

def finalize_mecab(model, tagger, lattice)
  LibMeCab.mecab_lattice_destroy(lattice)
  LibMeCab.mecab_destroy(tagger)
  LibMeCab.mecab_model_destroy(model)
end

describe "lib_mecab", "#general" do
  it "initializes the MeCab" do
    model, tagger, lattice = initialize_mecab("")
    finalize_mecab(model, tagger, lattice)
  end

  it "refuses invalid options" do
    model = LibMeCab.mecab_model_new2("--this-option-is-not-defined")
    model.null?.should be_true
  end
end

describe "lib_mecab", "#parse" do
  it "segments a sentence into words" do
    sentence = "すもももももももものうち"
    expected = "すもも も もも も もも の うち"

    model, tagger, lattice = initialize_mecab("-O wakati")

    LibMeCab.mecab_lattice_set_sentence(lattice, sentence)
    LibMeCab.mecab_parse_lattice(tagger, lattice)
    result_ptr = LibMeCab.mecab_lattice_tostr(lattice)
    result = String.new(result_ptr)

    result = result.rstrip()
    result.should eq(expected)

    finalize_mecab(model, tagger, lattice)
  end

  it "analyzes a sentence" do
    sentence = "今日もしないとね。"
    expected = [
      [ "今日", "名詞,副詞可能,*,*,*,*,今日,キョウ,キョー" ],
      [ "も",   "助詞,係助詞,*,*,*,*,も,モ,モ" ],
      [ "し",   "動詞,自立,*,*,サ変・スル,未然形,する,シ,シ" ],
      [ "ない", "助動詞,*,*,*,特殊・ナイ,基本形,ない,ナイ,ナイ", ]
      [ "と",   "助詞,接続助詞,*,*,*,*,と,ト,ト" ],
      [ "ね",   "助詞,終助詞,*,*,*,*,ね,ネ,ネ" ],
      [ "。",   "記号,句点,*,*,*,*,。,。,。" ]
    ]

    model, tagger, lattice = initialize_mecab("")

    LibMeCab.mecab_lattice_set_sentence(lattice, sentence)
    LibMeCab.mecab_parse_lattice(tagger, lattice)

    node_ptr = LibMeCab.mecab_lattice_get_bos_node(lattice)

    i = 0
    while (!node_ptr.null?)
      if (node_ptr.value.stat == LibMeCab::MECAB_NOR_NODE)
        surface = String.new(node_ptr.value.surface.to_slice(node_ptr.value.length.to_i32()))
        feature = String.new(node_ptr.value.feature)

        surface.should eq(expected[i][0])
        feature.should eq(expected[i][1])
        i += 1
      end

      node_ptr = node_ptr.value.next
    end

    finalize_mecab(model, tagger, lattice)
  end
end
