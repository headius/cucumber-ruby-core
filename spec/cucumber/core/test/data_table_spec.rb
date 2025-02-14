# encoding: utf-8
# frozen_string_literal: true

require 'cucumber/core/test/data_table'

module Cucumber
  module Core
    module Test
      describe DataTable do
        before do
          @table = described_class.new([
                                         %w[one four seven],
                                         %w[4444 55555 666666]
                                       ])
        end

        describe '#data_table?' do
          let(:table) { described_class.new([[1, 2], [3, 4]]) }

          it 'returns true' do
            expect(table).to be_data_table
          end
        end

        describe '#doc_string' do
          let(:table) { described_class.new([[1, 2], [3, 4]]) }

          it 'returns false' do
            expect(table).not_to be_doc_string
          end
        end

        describe '#map' do
          let(:table) { described_class.new([%w[foo bar], %w[1 2]]) }

          it 'yields the contents of each cell to the block' do
            expect { |b| table.map(&b) }.to yield_successive_args('foo', 'bar', '1', '2')
          end

          it 'returns a new table with the cells modified by the block' do
            expect(table.map { |cell| "*#{cell}*" }).to eq described_class.new([%w[*foo* *bar*], %w[*1* *2*]])
          end
        end

        describe '#transpose' do
          before(:each) do
            @table = described_class.new([
                                           %w[one 1111],
                                           %w[two 22222]
                                         ])
          end

          it 'should transpose the table' do
            transposed = described_class.new([
                                               %w[one two],
                                               %w[1111 22222]
                                             ])
            expect(@table.transpose).to eq(transposed)
          end
        end
      end
    end
  end
end
