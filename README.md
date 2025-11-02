# Домашнее задание к занятию «Продвинутые методы работы с Terraform»

## ` Дмитрий Климов `

## Задание 1

Возьмите из демонстрации к лекции готовый код для создания с помощью двух вызовов remote-модуля -> двух ВМ, относящихся к разным проектам(marketing и analytics) используйте labels для обозначения принадлежности. В файле cloud-init.yml необходимо использовать переменную для ssh-ключа вместо хардкода. Передайте ssh-ключ в функцию template_file в блоке vars ={} . Воспользуйтесь примером. Обратите внимание, что ssh-authorized-keys принимает в себя список, а не строку.
Добавьте в файл cloud-init.yml установку nginx.
Предоставьте скриншот подключения к консоли и вывод команды sudo nginx -t, скриншот консоли ВМ yandex cloud с их метками. Откройте terraform console и предоставьте скриншот содержимого модуля. Пример: > module.marketing_vm

## Ответ:

<img width="1920" height="1080" alt="Снимок экрана (1706)" src="https://github.com/user-attachments/assets/42ec8d57-0830-43e8-957d-0679b0f5fa6f" />

<img width="1920" height="1080" alt="Снимок экрана (1705)" src="https://github.com/user-attachments/assets/11d14e84-bdf0-4694-9f6a-99dce05143d9" />

<img width="1920" height="1080" alt="Снимок экрана (1703)" src="https://github.com/user-attachments/assets/195563d1-377d-4154-864d-1a5212bbddb0" />

<img width="1920" height="1080" alt="Снимок экрана (1704)" src="https://github.com/user-attachments/assets/6c0e096a-8c19-429a-9bc3-7cddeccb4bce" />

<img width="1920" height="1080" alt="Снимок экрана (1701)" src="https://github.com/user-attachments/assets/71fe1476-5844-447e-a771-66fc8e72c1f7" />

<img width="1920" height="1080" alt="Снимок экрана (1702)" src="https://github.com/user-attachments/assets/2ea87079-4adc-4e9f-8625-bdfd3dec7374" />





