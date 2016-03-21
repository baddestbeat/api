@app_path = '/var/www/api'
worker_processes 2
working_directory "#{@app_path}"


# This loads the application in the master process before forking
# worker processes
# Read more about it here:
# http://unicorn.bogomips.org/Unicorn/Configurator.html

preload_app true
timeout 30

# This is where we specify the socket.
# We will point the upstream Nginx module to this socket later on
listen "/var/www/api/tmp/unicorn.sock", :backlog => 64
pid "/var/www/api/tmp/unicorn.pid"

# Set the path of the log files inside the log folder of the testapp
stderr_path "/var/log/unicorn/unicorn.stderr.log"
stdout_path "/var/log/unicorn/unicorn.stdout.log"



#before_fork=>masterがworkerを産む直前に実行する処理を登録するメソッド
before_fork do |server, worker|
  # 確率されたコネクションを切断してそれぞれのプロセスで新たにサーバに接続(after_fork_do)
  defined?(ActiveRecord::Base) and ActiveRecord::Base.connection.disconnect!


  # workerの数が1以上ならTTOUを送ってworkerを減らす
  # workerの数が1なら古いmasterをkillする
  old_pid = "#{server.config[:pid]}.oldbin"
    if old_pid != server.pid
      begin
        sig = (worker.nr + 1) >= server.worker_processes ? :QUIT : :TTOU
        Process.kill(sig, File.read(old_pid).to_i)
      rescue Errno::ENOENT, Errno::ESRCH
      end
    end

    # 順次workerをkillするために、forkされる速度を落とす
    sleep 1
  end

after_fork do |server, worker|
  defined?(ActiveRecord::Base) and ActiveRecord::Base.establish_connection
end
