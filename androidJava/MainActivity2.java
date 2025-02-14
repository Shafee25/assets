package com.example.imarasoftwaredb;

import android.database.Cursor;
import android.os.Bundle;
import android.widget.ArrayAdapter;
import android.widget.ListView;
import android.widget.Toast;

import androidx.activity.EdgeToEdge;
import androidx.appcompat.app.AppCompatActivity;
import androidx.core.graphics.Insets;
import androidx.core.view.ViewCompat;
import androidx.core.view.WindowInsetsCompat;

import java.lang.reflect.Array;
import java.util.ArrayList;

public class MainActivity2 extends AppCompatActivity {
    ListView viewList;
    DatabaseHelper db = new DatabaseHelper(this);

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main2);

        viewList = findViewById(R.id.listViewId);

        Cursor cursor = db.getAllData();
        ArrayList<String> list = new ArrayList<>();

        if (cursor != null && cursor.moveToFirst()) {
            do {
                String record = "id: " + cursor.getInt(0) +
                        "\n Name: " + cursor.getString(1) +
                        "\n Price: " + cursor.getInt(2) +
                        "\n Category: " + cursor.getString(3) +
                        "\n Discount: " + cursor.getInt(4);

                list.add(record);
            } while (cursor.moveToNext());
            cursor.close();

            ArrayAdapter<String> adapter = new ArrayAdapter<>(MainActivity2.this, android.R.layout.simple_list_item_1,list);
            viewList.setAdapter(adapter);
        } else {
            Toast.makeText(this, "No Data Available", Toast.LENGTH_SHORT).show();
        }

    }
}