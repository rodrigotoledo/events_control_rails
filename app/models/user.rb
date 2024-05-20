# frozen_string_literal: true

class User < ApplicationRecord
  has_secure_password
  validates :name, presence: true

  validates :email, presence: true, email: true, uniqueness: { case_sensitive: false }
  validates :name, presence: true
  validates :password, presence: true, on: :create
  validates :password, confirmation: true, if: -> { password.present? && !password.nil? }, on: :update

  normalizes :email, with: ->(email) { email.strip.downcase }

  has_many :event_users, dependent: :destroy
  has_many :events, through: :event_users

  def reset_password
    # a logica aki eh gerar um email pra essa pessoa com uma tela de confirmacao de alteracao de senha
    true
  end
end
