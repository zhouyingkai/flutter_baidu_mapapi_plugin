package com.baidu.mapapi.search.utils;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.google.gson.reflect.TypeToken;

import java.util.HashMap;

public class GsonFactory {
    Gson gson = null;

    private static volatile GsonFactory sInstance;

    public static GsonFactory getInstance(){
        if(null == sInstance){
            sInstance = new GsonFactory();
        }

        return sInstance;
    }

    private GsonFactory(){
        gson = new GsonBuilder().registerTypeAdapter(new TypeToken<HashMap<String, Object>>(){}.getType(), new MapTypeAdapter())
                .enableComplexMapKeySerialization()
                .serializeSpecialFloatingPointValues()
                .create();
    }

    public Gson getGson(){
        return gson;
    }
}
