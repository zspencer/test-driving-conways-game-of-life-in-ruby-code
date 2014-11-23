187_version = 1.8.7-p375
187_env = RBENV_VERSION=$(187_version)

193_version = 1.9.3-p551
193_env = RBENV_VERSION=$(193_version)

20_version = 2.0.0-p598
20_env = RBENV_VERSION=$(20_version)

21_version = 2.1.5
21_env = RBENV_VERSION=$(21_version)


test_all = bundle exec ruby test/all.rb
test: test-187 test-193 test-20 test-21

test-187:
	$(187_env) $(test_all)

test-193:
	$(193_env) $(test_all)

test-20:
	$(20_env) $(test_all)

test-21:
	$(21_env) $(test_all)


install: install-187 install-193 install-20 install-21

install-187: install-ruby-187 install-gems-187
install-193: install-ruby-193 install-gems-193
install-20: install-ruby-20 install-gems-20
install-21: install-ruby-21 install-gems-21

install_ruby = rbenv install -s
install-ruby-187:
	$(install_ruby) $(187_version)

install-ruby-193:
	$(install_ruby) $(193_version)

install-ruby-20:
	$(install_ruby) $(20_version)

install-ruby-21:
	$(install_ruby) $(21_version)


install_bundler = gem install bundler
install_gems = bundle install
install-gems-187:
	$(187_env) $(install_bundler)
	$(187_env) $(install_gems)

install-gems-193:
	$(193_env) $(install_bundler)
	$(193_env) $(install_gems)

install-gems-20:
	$(20_env) $(install_bundler)
	$(20_env) $(install_gems)

install-gems-21:
	$(21_env) $(install_bundler)
	$(21_env) $(install_gems)
