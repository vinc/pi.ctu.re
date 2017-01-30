require 'rails_helper'

RSpec.describe "pictures/new", type: :view do
  before(:each) do
    assign(:picture, Picture.new(
      :caption => "MyText"
    ))
  end

  it "renders new picture form" do
    render

    assert_select "form[action=?][method=?]", pictures_path, "post" do

      assert_select "textarea#picture_caption[name=?]", "picture[caption]"
    end
  end
end
