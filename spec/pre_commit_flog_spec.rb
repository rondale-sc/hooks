require 'rspec'
require_relative '../hooks/pre_commit/pre_commit_flog.rb'

describe FlogPreCommit do
  context "#to_s" do
    let(:init_options) do
      { flog: stub(:flog => nil, :total => 100, :average => 17),
        files: ["example.rb"] }
    end

    context "When file has a ruby extension." do
      it "Prints the `flog` output for each file." do
        output = FlogPreCommit.new(init_options).to_s

        output.should eql("Flog: Avg ( \e[32m17\e[0m ), Total ( 100 ) - example.rb.")
      end

      it "When it receives a good score prints average in green." do
        output = FlogPreCommit.new(init_options).to_s

        output.should match(/\e\[32m/)
      end

      it "When it receives an okay score prints average in yellow." do
        options_with_okay_score = init_options.merge(flog: stub(:flog => nil, :total => 250, :average => 40))
        output = FlogPreCommit.new(options_with_okay_score).to_s

        output.should match(/\e\[33m/)
      end

      it "When it receives a poor score prints average in red." do
        options_with_poor_score = init_options.merge(flog: stub(:flog => nil, :total => 400, :average => 61))
        output = FlogPreCommit.new(options_with_poor_score).to_s

        output.should match(/\e\[31m/)
      end
    end

    context "When file has no ruby extension." do
      it "Should print nothing." do
        options_without_ruby_file = init_options.merge(files: ["not_a_ruby_file.py"])
        output = FlogPreCommit.new(options_without_ruby_file).to_s

        output.should be_empty
      end
    end
  end
end
