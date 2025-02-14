package com.example.imarasoftwaredb;

public class Food {
    public int id;
    public String name;
    public int price;
    public String category;
    public int discount;

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public int getPrice() {
        return price;
    }

    public void setPrice(int price) {
        this.price = price;
    }

    public String getCategory() {
        return category;
    }

    public void setCategory(String category) {
        this.category = category;
    }

    public int getDiscount() {
        return discount;
    }

    public void setDiscount(int discount) {
        this.discount = discount;
    }

    public Food(int id, String name, int price, String category, int discount) {
        this.id = id;
        this.name = name;
        this.price = price;
        this.category = category;
        this.discount = discount;
    }
}
