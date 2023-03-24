class NubanksController < ApplicationController
  before_action :set_nubank, only: %i[ show update destroy ]

  # GET /nubanks
  def index
    @nubanks = Nubank.all

    render json: @nubanks
  end

  # GET /nubanks/1
  def show
    render json: @nubank
  end

  # POST /nubanks
  def create
    @nubank = Nubank.new(nubank_params)

    if @nubank.save
      render json: @nubank, status: :created, location: @nubank
    else
      render json: @nubank.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /nubanks/1
  def update
    if @nubank.update(nubank_params)
      render json: @nubank
    else
      render json: @nubank.errors, status: :unprocessable_entity
    end
  end

  # DELETE /nubanks/1
  def destroy
    @nubank.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_nubank
      @nubank = Nubank.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def nubank_params
      params.require(:nubank).permit(:pagamento_id, :status, :data_pagamento, :transaction_id)
    end
end
