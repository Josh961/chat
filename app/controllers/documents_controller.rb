require 'date'
class DocumentController < ApplicationController
  def new
    @document = Document.create(document_name: params.require(:document_name), chatroom: params.require(:chatroom))
    @document.user = user_params # ? session[:current_user_id]
    @document.date_uploaded = DateTime.now
    @document.id = Documents.count - 1
    unless @document.save
      flash.now[:error] = "Could not create document"
    end
  end

  def delete
    Document.delete(Document.find_by(id: params.require(:id)))
  end

  def user_params # ?
    params[Clearance.configuration.user_parameter] || Hash.new
  end
end
