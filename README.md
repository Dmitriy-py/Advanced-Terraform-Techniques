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

## Задание 2

Напишите локальный модуль vpc, который будет создавать 2 ресурса: одну сеть и одну подсеть в зоне, объявленной при вызове модуля, например: ru-central1-a.
Вы должны передать в модуль переменные с названием сети, zone и v4_cidr_blocks.
Модуль должен возвращать в root module с помощью output информацию о yandex_vpc_subnet. Пришлите скриншот информации из terraform console о своем модуле. Пример: > module.vpc_dev
Замените ресурсы yandex_vpc_network и yandex_vpc_subnet созданным модулем. Не забудьте передать необходимые параметры сети из модуля vpc в модуль с виртуальной машиной.
Сгенерируйте документацию к модулю с помощью terraform-docs.

Пример вызова

```terraform
module "vpc_dev" {
  source       = "./vpc"
  env_name     = "develop"
  zone = "ru-central1-a"
  cidr = "10.0.1.0/24"
}
```
## Ответ:

<img width="1920" height="1080" alt="Снимок экрана (1707)" src="https://github.com/user-attachments/assets/25c1fde1-bbff-4b43-9d9b-f381981108b7" />

<img width="1920" height="1080" alt="Снимок экрана (1708)" src="https://github.com/user-attachments/assets/227391e7-f09d-4af7-bf51-22f135b61a9f" />


















