module SpreeBulkUpload
  module Processors
    class ProductAttributes < Base
      attr_reader :sku, :variants

      def initialize(sku, variants)
        @sku = sku
        @variants = variants
      end



      protected

      def attributes_mapping
        {
            'Name' => 'name',
            'Meta Keywords' => 'meta_keywords',
            'Meta Description' => 'meta_description',
            'Shipping Category' => {
                attr: 'shipping_category',
                value: lambda {|v| Spree::ShippingCategory.find_by_name!(v)}
            },
            'Tax Category' => {
                attr: 'tax_category',
                value: lambda {|v| Spree::TaxCategory.find_by_name!(v) }
            } ,
            'Cost' => 'cost_price',
            'Available on Date' => 'available_on',
            'Description' => 'description',
            'Master Price' => 'price',
            'Prototype' => 'prototype_id'
        }
      end

      def source_object
        variants.first
      end

    end
  end
end