require 'spec_helper'

module Doorkeeper
  describe Config do
    before :all do
      @old_config = Doorkeeper.send :class_variable_get, :@@config
    end

    after :all do
      Doorkeeper.send :class_variable_set, :@@config, @old_config
    end

    before :each do
      Doorkeeper.send :remove_class_variable, :@@config if Doorkeeper.class_variable_defined?(:@@config)
    end

    describe "resource_owner_authenticator" do
      it "sets the block that is accessible via authenticate_resource_owner" do
        block = proc do end
        config = Config.new do
          resource_owner_authenticator &block
        end
        config.authenticate_resource_owner.should == block
      end
    end

    describe "admin_authenticator" do
      it "sets the block that is accessible via authenticate_admin" do
        block = proc do end
        config = Config.new do
          admin_authenticator &block
        end
        config.authenticate_admin.should == block
      end
    end
  end
end
