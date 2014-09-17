class HelloWorld
  include Sidekiq::Worker

  def perform
    logger.info('hello world!')
  end

  def logger
    @logger ||= Logger.new('log/hello_world.log')
  end
end
