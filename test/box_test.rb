require 'test_helper'

describe StreakClient::Box do

  before(:each) do
    @pipeline = StreakClient::Pipeline.create(name: "Test", description: "T")
    @box = StreakClient::Box.create(@pipeline.pipelineKey, {name: "Test Box"})
  end

  after(:each) do
    StreakClient::Pipeline.delete(@pipeline.pipelineKey)
  end

  it "can create one" do
    @box.boxKey.wont_be_nil
  end

  it "can find one" do
    found = StreakClient::Box.find(@box.boxKey)
    found.name.must_equal "Test Box"
  end

  it "can delete one" do
    StreakClient::Box.delete(@box.boxKey)
    StreakClient::Box.all.size.must_equal 0
  end

  it "can find all" do
    all = StreakClient::Box.all
    all.size.must_be :>, 0
    all.first.name.must_equal "Test Box"
  end

  it "can edit one" do
    box_key = @box.boxKey
    @box.name = "New Name"
    @box.save!
    changed_box = StreakClient::Box.find(box_key)
    changed_box.name.must_equal "New Name"
  end

  it "can add a comment" do
    response = @box.add_comment("Comment")
    response["message"].must_equal "Comment"
  end

  it "can set field value" do
    response = @pipeline.add_field(name: "Test field", type: "TEXT_INPUT")
    key = response.key
    response = @box.set_field(key,"test@example.org")
    response["value"].must_equal "test@example.org"
  end

  it "can add a thread" do
    # TODO
  end

  it "can add a task" do
    # TODO
  end
end

