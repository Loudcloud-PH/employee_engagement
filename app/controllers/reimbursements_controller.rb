class ReimbursementsController < InheritedResources::Base
  http_basic_authenticate_with name: ENV["HTTP_AUTH_USERNAME"], password: ENV["HTTP_AUTH_PASSWORD"] if ENV["HTTP_AUTH_USERNAME"].present? && ENV["HTTP_AUTH_PASSWORD"].present?

  before_action :categories, only: [ :index, :new, :create ]
  before_action :employees, only: [ :index, :new, :create ]
  before_action :active_employees, only: [ :index, :new, :create ]
  before_action :participated_employees, only: [ :create, :update ]

  def index
    reimbursement_service = ReimbursementServices::GetReimbursements.call(params)

    @filed_reimbursements = reimbursement_service[:filed_reimbursements]
    @reimbursement_items = reimbursement_service[:reimbursement_items]
    @item_breakdown = reimbursement_service[:item_breakdown]

    @employee = Employee.find(params[:employee_id]) if params[:employee_id].present?
  end

  def new
    @reimbursement = Reimbursement.new
  end

  def create
    service = ReimbursementServices::CreateReimbursement.call(reimbursement_params)

    if service[:success]
      flash[:success] = "Reimbursement created successfully."
    else
      flash[:error] = service[:errors].join(", ")
    end

    redirect_to new_reimbursement_path
  end

  private

  def reimbursement_params
    params.require(:reimbursement).permit(:employee_id, :category_id, :activity_date, :invoice_reference_number, :invoice_amount, :image, :reimbursable_amount, :reimbursed_amount, :supplier, :status, participated_employee_ids: [])
  end

  def participated_employees
    params[:reimbursement][:participated_employee_ids].reject!(&:blank?) if params[:reimbursement][:participated_employee_ids]
  end

  def categories
    @categories = Category.where(status: "active").order(:name)
  end

  def employees
    @employees = Employee.where(status: "active").order(:nickname)
  end

  def active_employees
    @active_employees = Employee.where(status: "active", active: true).order(:nickname).pluck(:nickname, :id)
  end
end
