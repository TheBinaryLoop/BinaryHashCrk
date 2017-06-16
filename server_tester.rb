#!/usr/local/bin/ruby

#this script is for testing the server

#add all clients to this group to kill
$group_id = 0;

#all server to this group to pass on signals
$server_group_id = 0;

def get_new_port
	myport = 1000 + rand(5000)
	port = myport.to_s()
	puts "Testing on port "+port
	return port
end

def test1

	port = get_new_port
	puts "Testing with one client..."

	server_pid = fork do
		exec("./440server "+port+" >> /dev/null")
	end

	sleep 3.0

	request_pid = fork do
		exec("./440request_client 127.0.0.1 "+port+" aadInDGqoCgOM >> tempfile")
	end

	sleep 2.0

	client1_pid = fork do
		exec("./440worker_client 127.0.0.1 "+port+" >> /dev/null")
	end

	$group_id = Process.getpgid(client1_pid)

	Process.waitpid(request_pid)
	Process.kill("SIGTERM", server_pid);

	sleep 2.0

	grep_pid = fork do
		exec("cat tempfile | grep \"ADghb\" >> /dev/null")
	end

	Process.waitpid(grep_pid)

	return_val = $?
	if(return_val == 0)
		puts "Test1 passed."
	else
		puts "Test1 failed."
	end

end

def test2

	port = get_new_port
	puts "Testing with multiple clients..."

	server_pid = fork do
		exec("./440server "+port+" >> /dev/null")
	end

	sleep 2.0

	request_pid = fork do
		exec("./440request_client 127.0.0.1 "+port+" aadInDGqoCgOM >> tempfile")
	end

	sleep 2.0

	f1 = IO.popen("./440worker_client 127.0.0.1 "+port+" >> /dev/null")
	client1_pid = f1.pid

	f2 = IO.popen("./440worker_client 127.0.0.1 "+port+" >> /dev/null")
	client2_pid = f2.pid

	f3 = IO.popen("./440worker_client 127.0.0.1 "+port+" >> /dev/null")
	client3_pid = f3.pid

	Process.waitpid(request_pid)
	Process.kill("SIGTERM", server_pid);

	sleep 2.0

	grep_pid = fork do
		exec("cat tempfile | grep \"ADghb\" >> /dev/null")
	end

	Process.waitpid(grep_pid)

	return_val = $?
	if(return_val == 0)
		puts "Test2 passed."
	else
		puts "Test2 failed."
	end
end

def test3

	port = get_new_port
	puts "Testing single client failure..."

	server_pid = fork do
		exec("./440server "+port+" >> /dev/null")
	end

	sleep 2.0

	request_pid = fork do
		exec("./440request_client 127.0.0.1 "+port+" aadInDGqoCgOM >> tempfile")
	end

	f = IO.popen("./440worker_client 127.0.0.1 "+port+" >> /dev/null")
	client_pid = f.pid

	Process.kill("SIGKILL", client_pid)

	Process.wait(client_pid)

	client_pid = fork do	
		Process.setpgid(0, $group_id)
		exec("./440worker_client 127.0.0.1 "+port+" >> /dev/null")
	end

	Process.waitpid(request_pid)
	Process.kill("SIGTERM", server_pid);

	sleep 2.0

	grep_pid = fork do
		exec("cat tempfile | grep \"ADghb\" >> /dev/null")
	end

	Process.waitpid(grep_pid)

	return_val = $?
	if(return_val == 0)
		puts "Test3 passed."
	else
		puts "Test3 failed."
	end
end

def test4

	port = get_new_port
	puts "Testing multiple clients with LOSSY..."

	server_pid = fork do
		exec("./440server "+port+" >> /dev/null")
	end

	sleep 2.0

	request_pid = fork do
		exec("./440request_client 127.0.0.1 "+port+" aadInDGqoCgOM >> tempfile")
	end

	sleep 2.0

	f1 = IO.popen("./440worker_client 127.0.0.1 "+port+" >> /dev/null")
	client1_pid = f1.pid

	f2 = IO.popen("./440worker_client 127.0.0.1 "+port+" >> /dev/null")
	client2_pid = f2.pid

	f3 = IO.popen("./440worker_client 127.0.0.1 "+port+" >> /dev/null")
	client3_pid = f3.pid

	Process.waitpid(request_pid)
	Process.kill("SIGTERM", server_pid);

	sleep 2.0

	grep_pid = fork do
		exec("cat tempfile | grep \"ADghb\" >> /dev/null")
	end

	Process.waitpid(grep_pid)

	return_val = $?
	if(return_val == 0)
		puts "Test4 passed."
	else
		puts "Test4 failed."
	end
end

def test5

	port = get_new_port
	puts "Testing multiple clients with LOSSY...one dies"

	server_pid = fork do
		exec("./440server "+port+" >> /dev/null")
	end

	sleep 2.0

	request_pid = fork do
		exec("./440request_client 127.0.0.1 "+port+" aadInDGqoCgOM >> tempfile")
	end

	sleep 2.0

	f1 = IO.popen("./440worker_client 127.0.0.1 "+port+" >> /dev/null")
	client1_pid = f1.pid

	f2 = IO.popen("./440worker_client 127.0.0.1 "+port+" >> /dev/null")
	client2_pid = f2.pid

	f3 = IO.popen("./440worker_client 127.0.0.1 "+port+" >> /dev/null")
	client3_pid = f3.pid

	Process.kill("SIGKILL", client2_pid)

	Process.waitpid(request_pid)
	Process.kill("SIGTERM", server_pid);

	sleep 3.0

	grep_pid = fork do
		exec("cat tempfile | grep \"ADghb\" >> /dev/null")
	end

	Process.waitpid(grep_pid)

	return_val = $?
	if(return_val == 0)
		puts "Test5 passed."
	else
		puts "Test5 failed."
	end

end

ENV['LOSSY'] = '0'
test1
system("rm tempfile")

test2
system("rm tempfile")

test3
system("rm tempfile")

ENV['LOSSY'] = '10'
test4
system("rm tempfile")

test5
system("rm tempfile")

#kill any remaining clients
Process.kill("-SIGKILL", $group_id)
