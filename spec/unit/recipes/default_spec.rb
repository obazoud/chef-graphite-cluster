#
# Cookbook Name:: graphite-cluster
# Spec:: default
#
# Copyright (c) 2015 The Authors, All Rights Reserved.

require 'spec_helper'

describe 'graphite-cluster::default' do
  cached(:chef_run) do
    ChefSpec::ServerRunner.converge(described_recipe)
  end

  it 'converges successfully' do
    chef_run # This should not raise an error
  end
end
