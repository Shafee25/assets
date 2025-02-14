package com.example.imarasoftwaredb;

import android.annotation.SuppressLint;
import android.content.Intent;
import android.os.Bundle;

import android.view.View;
import android.widget.*;
import androidx.activity.EdgeToEdge;
import androidx.appcompat.app.AppCompatActivity;
import androidx.core.graphics.Insets;
import androidx.core.view.ViewCompat;
import androidx.core.view.WindowInsetsCompat;

public class MainActivity extends AppCompatActivity {
    EditText name,price;
    TextView discount, display;
    Spinner category;
    SeekBar seekBar;

    Button add, view, fetch;

    DatabaseHelper db = new DatabaseHelper(this);

    @SuppressLint("MissingInflatedId")
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        EdgeToEdge.enable(this);
        setContentView(R.layout.activity_main);

        name = (EditText) findViewById(R.id.nameId);
        price = (EditText) findViewById(R.id.priceId);
        discount = (TextView) findViewById(R.id.displayId);
        display = (TextView) findViewById(R.id.dataShowId);
        category = (Spinner) findViewById(R.id.selectId);
        seekBar = (SeekBar) findViewById(R.id.seekbarId);

        add = (Button) findViewById(R.id.addBtn);
        view = (Button) findViewById(R.id.viewBtn);
        fetch = (Button) findViewById(R.id.readBtnId);

        String[] categories = {"veg", "non-veg"};
        ArrayAdapter<String> adapter = new ArrayAdapter<>(this, android.R.layout.simple_spinner_dropdown_item, categories);
        category.setAdapter(adapter);

        seekBar.setOnSeekBarChangeListener(new SeekBar.OnSeekBarChangeListener() {
            @Override
            public void onProgressChanged(SeekBar seekBar, int progress, boolean fromUser) {
                discount.setText("Discount "+progress+"%");
            }

            @Override
            public void onStartTrackingTouch(SeekBar seekBar) {

            }

            @Override
            public void onStopTrackingTouch(SeekBar seekBar) {

            }
        });

        add.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                insertFood();
                clearField();
            }
        });

        view.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                startActivity(new Intent(MainActivity.this, MainActivity2.class));
            }
        });

        fetch.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                String itemName = name.getText().toString().trim();
                Food food = db.fetchData(itemName);

                if (food != null) {
                    String message = "Name: " + food.getName() + "\n Price: " + food.getPrice() +
                                "\n Category: " + food.getCategory() + "\n Discount: " + food.getDiscount();
                    display.setText(message);
                    display.setVisibility(View.VISIBLE);
                } else {
                    Toast.makeText(MainActivity.this, "Food Not Available", Toast.LENGTH_SHORT).show();
                }
            }
        });

    }

    private void clearField() {
        name.setText(null);
        price.setText(null);
        discount.setText(null);
        seekBar.setProgress(0);
        
    }

    private void insertFood() {
        String itemName = name.getText().toString().trim();
        String fPrice = price.getText().toString().trim();
        String foodCategory = category.getSelectedItem().toString();
        int discount = seekBar.getProgress();

        if (!itemName.isEmpty() && !fPrice.isEmpty() && !foodCategory.isEmpty()) {
            int itemPrice = Integer.parseInt(fPrice);
            boolean result = db.addBillData(itemName,itemPrice,foodCategory,discount);

            if (result) {
                Toast.makeText(this, "Invoice Added", Toast.LENGTH_SHORT).show();
            } else {
                Toast.makeText(this, "Invoice Adding Failed", Toast.LENGTH_SHORT).show();
            }
        } else {
            Toast.makeText(this, "Fill the empty field", Toast.LENGTH_SHORT).show();
        }
    }
}