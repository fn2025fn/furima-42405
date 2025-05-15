# テーブル設計

## users テーブル

| Column             | Type   | Options     |
| ------------------ | ------ | ----------- |
| nickname           | string | null: false |
| last_name          | string | null: false |
| first_name         | string | null: false |
| last_name_kana     | string | null: false |
| first_name_kana    | string | null: false |
| birth_date         | date   | null: false |
| email              | string | null: false, unique: true |
| encrypted_password | string | null: false |

## items テーブル

| Column           | Type     | Options     |
| ---------------- | ------   | ----------- |
| name             | string   | null: false |
| description      | text     | null: false |
| category_id      | integer   | null: false |
| condition_id     | integer   | null: false |
| price            | integer   | null: false |
| user             | references  | null: false, foreign_key: true |

## purchase_records テーブル

| Column | Type       | Options                        |
| ------ | ---------- | ------------------------------ |
| user   | references | null: false, foreign_key: true |
| item   | references | null: false, foreign_key: true |

## shipping_addresses テーブル

| Column                | Type       | Options     |
| --------------------- | ---------- | ------------|
| postal_code           | string     | null: false |
| prefecture_id         | integer    | null: false |
| city                  | string     | null: false |
| address               | string     | null: false |
| building              | string     |             |
| phone_number          | string     | null: false |
| shipping_fee_id       | integer    | null: false |
| delivery_time_id      | integer    | null: false |
| purchase_record       | references | null: false, foreign_key: true |