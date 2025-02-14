package com.example.imarasoftwaredb;

import android.content.ContentValues;
import android.content.Context;
import android.database.Cursor;
import android.database.sqlite.SQLiteDatabase;
import android.database.sqlite.SQLiteOpenHelper;
import androidx.annotation.Nullable;

public class DatabaseHelper extends SQLiteOpenHelper {
    private static final String DATABASE_NAME = "food.db";
    private static final int DB_VERSION = 1;
    private static final String TABLE_NAME = "foodTable";
    private static final String COLUMN_ID = "id";
    private static final String COLUMN_NAME = "name";
    private static final String COLUMN_PRICE = "price";
    private static final String COLUMN_CATEGORY = "category";
    private static final String COLUMN_DISCOUNT = "discount";
    public DatabaseHelper(@Nullable Context context) {
        super(context, "food.db", null, 1);
    }

    @Override
    public void onCreate(SQLiteDatabase db) {
        db.execSQL("CREATE TABLE foodTable (id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT, price TEXT, category TEXT, discount TEXT)");
    }

    @Override
    public void onUpgrade(SQLiteDatabase db, int oldVersion, int newVersion) {
        db.execSQL("DROP TABLE IF EXISTS " + TABLE_NAME);
        onCreate(db);
    }

    public boolean addBillData(String name, int price, String category, int discount) {
        SQLiteDatabase db = this.getWritableDatabase();
        ContentValues values = new ContentValues();

        values.put(COLUMN_NAME, name);
        values.put(COLUMN_PRICE, price);
        values.put(COLUMN_CATEGORY, category);
        values.put(COLUMN_DISCOUNT, discount);

        long result = db.insert(TABLE_NAME, null, values);
        return result != -1;
    }

    public Food fetchData(String name) {
        SQLiteDatabase db = this.getReadableDatabase();
        Cursor cursor = db.query(
                TABLE_NAME,
                null,
                COLUMN_NAME + "=?",
                new String[] {name},
                null,
                null,
                null
        );
        if (cursor != null && cursor.moveToFirst()) {
            Food food = new Food(
                    cursor.getInt(0), // id
                    cursor.getString(1), // name
                    cursor.getInt(2), // price
                    cursor.getString(3), // category
                    cursor.getInt(4) // discount
            );
            cursor.close();
            return food;
        }
        return null;
    }

    public Cursor getAllData() {
        SQLiteDatabase db = this.getReadableDatabase();

        Cursor cursor = db.query(TABLE_NAME, null, null,null,null,null,null,null);
//        cursor.close();
        return cursor;
    }
}
