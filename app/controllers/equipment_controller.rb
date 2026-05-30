class EquipmentController < ApplicationController
  def index
    equipment = Equipment.includes(:category).order(:name)

    if params[:status].present?
      equipment = equipment.where(status: params[:status])
    end

    render json: equipment.as_json(include: { category: { only: :name } })
  end

  def show
    equipment = Equipment.includes(:category, :maintenance_records).find(params[:id])

    render json: equipment.as_json(
      include: {
        category: { only: :name },
        maintenance_records: { order: { performed_at: :desc } }
      }
    )
  rescue ActiveRecord::RecordNotFound
    render json: { error: "Equipment not found" }, status: :not_found
  end

  def create
    equipment = Equipment.new(equipment_params)

    if equipment.save
      render json: equipment, status: :created
    else
      render json: { errors: equipment.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def update
    equipment = Equipment.find(params[:id])

    if equipment.update(equipment_params)
      render json: equipment
    else
      render json: { errors: equipment.errors.full_messages }, status: :unprocessable_entity
    end
  rescue ActiveRecord::RecordNotFound
    render json: { error: "Equipment not found" }, status: :not_found
  end

  def destroy
    equipment = Equipment.find(params[:id])
    equipment.destroy
    head :no_content
  rescue ActiveRecord::RecordNotFound
    render json: { error: "Equipment not found" }, status: :not_found
  end

  private

  def equipment_params
    params.require(:equipment).permit(:name, :serial_number, :status, :category_id)
  end
end
