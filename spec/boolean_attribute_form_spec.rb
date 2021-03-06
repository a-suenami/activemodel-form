require_relative 'spec_helper'

describe ActiveModel::Form do
  # Boolean params generated by the Rails form helpers look like this
  let(:params) do
    { "form"=>
      {"not_checked"=>"0",
       "checked"=>"1"}
    }
  end

  it "parses the Rails form helper boolean params" do
    class FormWithBooleans < ActiveModel::Form
      attribute :not_checked, :boolean
      attribute :checked, :boolean
      attribute :not_set, :boolean
    end

    form = FormWithBooleans.new(params['form'])
    form.not_checked.must_equal false
    form.checked.must_equal true
    form.not_set.must_equal nil # TODO: Should this be nil or false?
  end

  it "accepts ordinary booleans" do
    class FormWithBooleans < ActiveModel::Form
      attribute :checked, :boolean
      attribute :not_checked, :boolean
    end

    form = FormWithBooleans.new(:checked => true, :not_checked => false)
    form.checked.must_equal true
    form.not_checked.must_equal false
  end
end
