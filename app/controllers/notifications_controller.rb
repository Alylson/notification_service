class NotificationsController < ApplicationController
    def create
        task = params[:task_id]
        extracted_data = params[:notification_payload]
        
        if extracted_data[:price].nil? || extracted_data[:brand].nil? || extracted_data[:model].nil?
            render json: { error: 'Missing data in notification payload' }, status: :bad_request
            return
        end

        notification = Notification.new(
            task_id: task,
            extracted_data: "Preço #{extracted_data[:price]}. Marca #{extracted_data[:brand]}. Modelo: #{extracted_data[:model]}."
        )
      
        if notification.save
            render json: { message: "Notification created and sent successfully" }, status: :created
        else
            render json: notification.errors, status: :unprocessable_entity
        end
    end
end
  