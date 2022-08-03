class Request < ApplicationRecord
    belongs_to :user
    belongs_to :patient , class_name: "User"

    enum status: { pending: 0, rejected: 1, accepted: 2}
end
