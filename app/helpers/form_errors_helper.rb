# Ducks f.object from form_for, which allows dynamic creation of form error messages using
# view/shared/_error_messages.html.erb with a form_tag form.
#
# 'app/controllers/controller.rb'
#
# class Controller < ApplicationController
#   include FormErrorsHelper
#
#   def new
#     @form_errors ||= SignInFormErrors.new
#   end
#
#   def create
#     # most of create method ommitted...
#     # if there was an error
#       @form_errors ||= FormErrors.new("Invalid email format", "invalid email/password
#       combination")
#       render 'new'
#   end
# end
#
# 'app/views/model_name/new.html.erb'
# <# headings %>
#
# <%= render 'shared/error_messages', object: @errors %>
#
# <= form_tag 'path' do >
# <# form body ommitted %>
# <% end %>

module FormErrorsHelper

  class FormErrors < Object
    attr_accessor :errors

    def initialize(*errors)
      @errors = ErrorFields.new(errors)
    end

    def <<(error)
      @errors << error
    end
  end

  class ErrorFields < Array

    def full_messages
      self
    end
  end
end
