require 'spec_helper'

describe Asset do
  it { should validate_presence_of(:name) }
end
