class MaintenanceRecordsController < ApplicationController
  def index
    records = MaintenanceRecord.includes(:equipment).order(performed_at: :desc)

    if params[:equipment_id].present?
      records = records.where(equipment_id: params[:equipment_id])
    end

    render json: records.as_json(include: { equipment: { only: :name } })
  end

  def show
    record = MaintenanceRecord.includes(:equipment).find(params[:id])

    render json: record.as_json(include: { equipment: { only: :name } })
  rescue ActiveRecord::RecordNotFound
    render json: { error: "Maintenance record not found" }, status: :not_found
  end

  def create
    record = MaintenanceRecord.new(record_params)

    if record.save
      render json: record, status: :created
    else
      render json: { errors: record.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def update
    record = MaintenanceRecord.find(params[:id])

    if record.update(record_params)
      render json: record
    else
      render json: { errors: record.errors.full_messages }, status: :unprocessable_entity
    end
  rescue ActiveRecord::RecordNotFound
    render json: { error: "Maintenance record not found" }, status: :not_found
  end

  def destroy
    record = MaintenanceRecord.find(params[:id])
    record.destroy
    head :no_content
  rescue ActiveRecord::RecordNotFound
    render json: { error: "Maintenance record not found" }, status: :not_found
  end

  private

  def record_params
    params.require(:maintenance_record).permit(:description, :performed_at, :equipment_id)
  end
end
