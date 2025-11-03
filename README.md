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

### `Ссылка на код:` https://github.com/Dmitriy-py/Advanced-Terraform-Techniques/tree/6e140dd0dc2b7cfffdfd6ac9b02fd9813865a1e1/%D0%97%D0%B0%D0%B4%D0%B0%D0%BD%D0%B8%D0%B5%20%E2%84%961

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

### `Ссылка на код:` 

## Задание 3

Выведите список ресурсов в стейте.
Полностью удалите из стейта модуль vpc.
Полностью удалите из стейта модуль vm.
Импортируйте всё обратно. Проверьте terraform plan. Значимых(!!) изменений быть не должно. Приложите список выполненных команд и скриншоты процессы.

## Ответ:

### `Список выполненных команд`
```terraform
terraform state list
terraform state rm module.vpc_dev
terraform state rm module.marketing_vm
terraform state rm module.analytics_vm
terraform import module.vpc_dev.yandex_vpc_network.network <NETWORK_ID>
terraform import module.vpc_dev.yandex_vpc_subnet.subnet <SUBNET_ID>
terraform import module.marketing_vm.yandex_compute_instance.vm fhmqnlo5duiip6cirp0e
terraform import module.analytics_vm.yandex_compute_instance.vm fhm5m6cu5lp5vl162h11
```

<img width="1920" height="1080" alt="Снимок экрана (1717)" src="https://github.com/user-attachments/assets/0709e5d8-4e24-4e79-be75-084651ae48ae" />

<img width="1920" height="1080" alt="Снимок экрана (1712)" src="https://github.com/user-attachments/assets/a3712705-54e0-4f58-b2f3-e91ebc5fc972" />

<img width="1920" height="1080" alt="Снимок экрана (1715)" src="https://github.com/user-attachments/assets/3d7e0e64-7c17-4e35-9b77-5cbc3961fed8" />

<img width="1920" height="1080" alt="Снимок экрана (1716)" src="https://github.com/user-attachments/assets/8ae516d4-712c-42dc-bf14-7ec24dad1f57" />








