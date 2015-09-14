Rails.application.config.exceptions_app = ->(env) { ErrorsController.action(:show).call(env) }
