# frozen_string_literal: true

require 'pathname'

class UnarBxf
  def initialize(filepath)
    @src = filepath
    @base_path = Pathname.new("#{__dir__}/../../bin/unar").cleanpath
    @binary_path = UnarBxf.configuration.binary_path
  end

  private

  def run(args)
    output = if @binary_path.nil? || @binary_path&.empty?
               `LD_LIBRARY_PATH=#{@base_path} #{@base_path}/unar #{args}`
             else
               `#{@binary_path} #{args}`
             end

    { ok: $?.success?, out: output }
  end
end

