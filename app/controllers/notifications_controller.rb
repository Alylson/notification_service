class NotificationsController < ApplicationController
    def create
        user = get_user(params[:user_id])
        task = get_task(params[:task_id])
        extracted_data = get_extracted_data(params[:task_id])
        
        notification = Notification.new(
            task_id: task[:id],
            task_url: params[:task_url],
            task_status: params[:task_status],
            user_id: params[:user_id],
            user_name: params[:user_name],
            user_email: params[:user_email],
            extracted_data: params[:extracted_data]
            #message: "Usuário #{user[:name]} concluiu a tarefa #{task[:url]}. Dados extraídos: #{extracted_data}.",
            #notification_type: params[:notification_type],
        )
      
        if notification.save
            #send_notification(notification)
            render json: { message: "Notification created and sent successfully" }, status: :created
        else
            render json: notification.errors, status: :unprocessable_entity
        end
    end
  
    private
  
    # def get_user(user_id)
    #     response = Faraday.get("http://auth_service/users/#{user_id}")
    #     JSON.parse(response.body, symbolize_names: true)
    # end
    
    # def get_task(task_id)
    #     response = Faraday.get("http://task_service/tasks/#{task_id}")
    #     JSON.parse(response.body, symbolize_names: true)
    # end
    
    # def get_extracted_data(task_id)
    #     response = Faraday.get("http://scraping_service/tasks/#{task_id}/data")
    #     JSON.parse(response.body, symbolize_names: true)[:extracted_data]
    # end
  
    # def send_notification(notification)
    #     case notification.notification_type
    #     when 'push'
    #         # Lógica para enviar push notification
    #     end
    # end
end
  