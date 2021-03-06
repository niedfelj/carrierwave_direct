# encoding: utf-8

require 'spec_helper'

describe CarrierWaveDirect::ActionViewExtensions::FormHelper do
  include FormBuilderHelpers

  describe "#direct_upload_form_for" do
    it "should yield an instance of CarrierWaveDirect::FormBuilder" do
      direct_upload_form_for(direct_uploader) do |f|
        f.should be_instance_of(CarrierWaveDirect::FormBuilder)
      end
    end

    context "the form" do
      before do
        direct_uploader.stub(:direct_fog_url).and_return("http://example.com")
      end

      it "should post to the uploader's #direct_fog_url as a multipart form" do
        form.should submit_to(
          :action => "http://example.com", :method => "post", :enctype => "multipart/form-data"
        )
      end

      it "should include any html options passed as through :html" do
        form(:html => { :target => "_blank_iframe" }).should submit_to(
          :action => "http://example.com", :method => "post", :enctype => "multipart/form-data", :target => "_blank_iframe"
        )
      end
    end
  end

end

