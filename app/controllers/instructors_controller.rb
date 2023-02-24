class InstructorsController < ApplicationController
  def index
    instructor = Instructor.all
    render json: instructor, status: :ok
  end

  def show
    instructor = Instructor.find_by(id: params[:id])
   if instructor
    render json: instructor, status: :created
   else
   render json: {error: 'Instructor not found'}, status: :not_found
   end
  end

  def create
    instructor = Instructor.create!(name: params[:name])
    if instructor.valid?
      render json: instructor, status: :created
    else
      render json: {errors: instructor.errors}, status: :unprocessable_entity
    end
  end

  def update
    instructor = Instructor.find_by(id: params[:id])
    if instructor
        instructor.update(name: params[:name])
        if instructor.valid?
            render json: instructor, status: :ok
        else
            render json: {errors: instructor.errors}, status: :unprocessable_entity
        end
    else
        render json: {error: "Instructor Not Found!"}, status: :not_found
    end
  end

  def destroy
    instructor = Instructor.find_by(id: params[:id])
        if instructor
            instructor.destroy
            render json: {}, status: :no_content
        else
            render json: {error: "Instructor Not Found!"}, status: :not_found
        end
  end

end
