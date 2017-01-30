require 'rails_helper'

RSpec.describe "pictures/index", type: :view do
  before(:each) do
    assign(:pictures, [
      Picture.create!(
        :caption => "MyText"
      ),
      Picture.create!(
        :caption => "MyText"
      )
    ])
  end

  it "renders a list of pictures" do
    render
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
  end
end
