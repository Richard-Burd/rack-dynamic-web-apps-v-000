require_relative "./config/environment.rb"
run SinatraApp.new
# run Protocol.new
# run MyProgram.new
# run Application.new

# So why can I do a "run App" in a later lab:
# https://github.com/learn-co-students/sinatra-basic-routes-lab-v-000/blob/master/config.ru
# ... Paul Susmarski speculates that Sinatra has
# some method like this thing below:
=begin
def run(app)
  if app.is_a?(Sinatra::Base)
    app.start
  else
    app.new.start()
  end
end
=end
