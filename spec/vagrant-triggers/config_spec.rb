require "spec_helper"

describe VagrantPlugins::Triggers::Config do
  let(:config)  { described_class.new }
  let(:machine) { double("machine") }

  describe "defaults" do
    subject do
      config.tap do |o|
        o.finalize!
      end
    end

    its("triggers") { should eq [] }
  end

  describe "accept multiple entries" do
    it "should record multiple entries" do
      config.before :up, :exec => "echo ls"
      config.after :up, :exec => "echo ls"
      expect(config.triggers).to have(2).items
    end
  end

  describe "validation" do
    it "should validate" do
      config.finalize!
      expect(config.validate(machine)["triggers"]).to have(:no).items
    end

    it "shouldn't accept invalid methods" do
      config.foo "bar"
      expect(config.validate(machine)["triggers"]).to have(1).item
    end
  end
end