require "spec_helper"

describe Buffet::Runner do
  let(:offline_slave) { Buffet::Slave.new(nil, "offline_host", "test_project") }
  let(:online_slave) { Buffet::Slave.new(nil, "127.0.0.1", "test_project") }

  before :each do
    Buffet::Settings.stub(:slaves).and_return([online_slave, offline_slave])
  end

  it "should ignore not available slaves" do
    subject.collect_slaves
    subject.instance_variable_get(:@slaves).should == [online_slave]
  end
end
