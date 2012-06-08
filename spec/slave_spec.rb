require "spec_helper"

describe Buffet::Slave do
  describe "offline" do
    subject { Buffet::Slave.new(nil, 'offline_host', 'test_project') }
    it { should_not be_available }
  end

  describe "online" do
    subject { Buffet::Slave.new(nil, '127.0.0.1', 'test_project') }
    it { should be_available }
  end
end