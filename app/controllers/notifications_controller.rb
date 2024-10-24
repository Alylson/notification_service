class NotificationsController < ApplicationController
    def create
        task = params[:task_id]
        extracted_data = params[:notification_payload]
        
        if task.nil? 
            render json: { error: 'Missing data in notification payload' }, status: :bad_request
            return
        end

        notification = if extracted_data.present?
            Notification.new(
                task_id: task,
                extracted_data: "Price #{extracted_data[:price]}. Brand #{extracted_data[:brand]}. Model: #{extracted_data[:model]}."
            )
        else
            Notification.new(
              task_id: task,
              extracted_data: "Task created."
            )
          end
      
        if notification.save
            render json: { message: "Notification created and sent successfully" }, status: :created
        else
            render json: notification.errors, status: :unprocessable_entity
        end
    end
end
