class StudentsController < ApplicationController
  def index
  student = Student.all
  render json: student, status: :ok
  end

  def show
    student = Student.find_by(id: params[:id])
    if student
    render json: student, status: :created
   else
   render json: {error: 'Student not found'}, status: :not_found
   end
  end

  def create
    instructor = Instructor.find_by(id: params[:id]) #show the instructor id
    if instructor # when associate with the instructor
      student = Student.create!(student_params)
      if student.valid? #create the student
        render json: stundent, status: :created
      else
        render json: {errors: student.errors}, status: :unprocessable_entity
      end
    else
      render json: {error: "Invalid Instructor ID! Instructor Not Found!"}, status: :not_found
    end
  end

  def update
    student = Student.find_by(id: params[:id])
    render json: {error: "Student not found"}, status: :not_found unless
    render json: student, status: :success

    instructor = Instructor.find_by(id: params[:instructor_id]) #only update id of instructor
    render json: {error: "Student not found"}, status: :not_found unless
    render json: instructor, status: :success

    #update student with params
    student.update(student_params)
    if student.valid?
      render json: student, status: :ok
    else
      render json: {errors: student.errors}, status: :unprocessable_entity
    end
  end

  def destroy
    student = Student.find_by(id: params[:id])
    student.destroy
    if student
    render json: {}, status: :no_content
    else
      render json: {error: "Student not found"}, status: :not_found
    end
  end

  private
  def student_params
    params.permit(:name, :age, :major, :instructor_id)
  end
end
