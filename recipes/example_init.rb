web_app_jar = 'https://github.com/EtienneK/spring-boot-web-sample/raw/master/dist/spring-boot-web-sample-0.0.1-SNAPSHOT.jar'

spring_boot_web_app 'app_0_initd' do
  jar_remote_path web_app_jar
  init_system 'init.d'
  port 9090
end

spring_boot_web_app 'app_1_initd' do
  jar_remote_path web_app_jar
  init_system 'init.d'
  user 'another_bootapp_user'
  group 'another_bootapp_group'
  port 9091
  properties Hash['a', 100, 'b', 200]
  java_opts '-Xmx256m -Xms128m'
  boot_opts '--spring.application.name=app_1_initd'

  wait_for_http true
  wait_for_http_retries 60
  wait_for_http_retry_delay 2
end

spring_boot_web_app 'app_2_initd' do
  jar_remote_path web_app_jar
  init_system 'init.d'
  port 9092

  java_opts '-Xmx256m -Xms128m'
  boot_opts '--spring.application.name=app_2_initd'
end

spring_boot_web_app 'app_0_initd' do
  action :uninstall
  init_system 'init.d'
end
