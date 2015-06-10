require_relative '../spec_helper'
describe SyntaxSugar::NullObject do

  let(:target_object) { double('sample object', :[] => 'GET', :[]= => 'SET') }
  let(:method_pointers) {
    {
        /^(.*)=$/ => :[]=,
        /^(.*)$/ => :[]
    }
  }

  subject { self.described_class.new(target_object, method_pointers) }

  it 'should be a BasicObject' do
    subject_class= (
    class << subject;
      self
    end
    ).superclass
    expect(subject_class).to be_a BasicObject
  end

  describe '#initialize' do
    context 'when invalid method pointer given' do

      context "and it's type wrong" do
        let(:method_pointers) { 'not valid pointer' }

        it 'should raise error' do
          expect { subject }.to raise_error(ArgumentError, /method pointer collection should be instance of Hash or Array/i)
        end
      end

      context 'when passed method pointer collection pointing objects are not regular expressions' do

        let(:method_pointers) {{ 'invalid pointer' => :valid_target_method }}
        it 'should raise error and warn about the invalid pointer type' do
          expect{ subject }.to raise_error(ArgumentError)
        end

      end

      context 'when passed method caller method is not a valid string or symbol' do

        let(:method_pointers) {{ /valid/ => /not valid/ }}
        it 'should raise error and warn about the invalid pointer type' do
          expect{ subject }.to raise_error(ArgumentError)
        end

      end


    end
  end

  describe '#method_missing' do

    context 'when method pointer regular expression has group' do

      let(:method_pointers) { {/^(.*)=$/ => :[]=} }

      it 'should use given method and  method on the object' do

        expect(target_object).to receive(method_pointers.to_a[0][1]).with('sample', 123)
        subject.sample = 123

      end

    end

    context 'when method pointer does not containt group' do

      let(:method_pointers) { {/^.*$/ => :some_call} }
      it 'should not pass the extracted content as first parameter' do

        expect(target_object).to receive(:some_call).with('hello')
        subject.say 'hello'

      end

    end

    context 'when no pointer find any match' do

      let(:method_pointers){{}}
      it 'should raise an undefined error' do

        expect{ subject.undefined_method_call }.to raise_error(NameError)

      end

    end

  end

end