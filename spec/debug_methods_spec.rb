class Example
  include DebugMethods
end
RSpec.describe DebugMethods do
  let(:described_class) { Example }
  subject { described_class.new }
  
  it "has a version number" do
    expect(DebugMethods::VERSION).not_to be nil
  end
  
  context "when Rails.env is not development" do
    before do
      allow(described_class).to receive(:development?).and_return(false)
      class Example
        debug_methods do
          def self.my_class_method
            true
          end
          
          def my_instance_method
            false
          end
        end
      end
    end
    it "has not defined my class method" do
      expect(described_class).not_to respond_to(:my_class_method)
    end
    it "has not defined my instance method" do
      expect(subject).not_to respond_to(:my_instance_method)
    end
  end
  
  context "when Rails.env is development" do
    before do
      allow(described_class).to receive(:development?).and_return(true)
      class Example
        debug_methods do
          def self.my_class_method
            true
          end
          
          def my_instance_method
            false
          end
        end
      end
    end
    it "has not defined my class method" do
      expect(described_class).to respond_to(:my_class_method)
    end
    it "has not defined my instance method" do
      expect(subject).to respond_to(:my_instance_method)
    end
  end
  
  describe "#configure" do
    context "when using default configuration" do
      it "has the default environments" do
        expect(DebugMethods.configuration.environments.count).to eq 3
      end
    end
    context "when using custom configuration" do
      before do
        DebugMethods.configure do |config|
          config.environments = [:dev]
        end
      end
      it "has the custom environment" do
        expect(DebugMethods.configuration.environments).to eq [:dev]
      end
    end
  end
  
end
