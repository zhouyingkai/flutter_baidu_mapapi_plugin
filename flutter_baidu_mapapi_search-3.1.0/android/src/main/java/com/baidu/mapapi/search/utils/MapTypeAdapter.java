package com.baidu.mapapi.search.utils;

import com.google.gson.TypeAdapter;
import com.google.gson.stream.JsonReader;
import com.google.gson.stream.JsonToken;
import com.google.gson.stream.JsonWriter;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class MapTypeAdapter extends TypeAdapter<Object> {
    @Override
    public Object read(JsonReader in) throws IOException {
        JsonToken token = in.peek();
        switch (token) {
            case BEGIN_ARRAY:
                List<Object> list = new ArrayList<Object>();
                in.beginArray();
                while (in.hasNext()) {
                    list.add(read(in));
                }
                in.endArray();
                return list;

            case BEGIN_OBJECT:
                Map<String, Object> map = new HashMap<String, Object>();
                in.beginObject();
                while (in.hasNext()) {
                    map.put(in.nextName(), read(in));
                }
                in.endObject();
                return map;

            case STRING:
                return in.nextString();

            case NUMBER:
                //将其作为一个字符串读取出来
                String numberStr = in.nextString();
                //返回的numberStr不会为null

                if ((numberStr.contains(".")
                             || numberStr.contains("e")
                             || numberStr.contains("E"))) {
                    try {
                        return Double.parseDouble(numberStr);
                    } catch (NumberFormatException e) {
                        e.printStackTrace();
                        return null;
                    }
                }

                try {
                    return Long.parseLong(numberStr);
                } catch (NumberFormatException e) {
                    e.printStackTrace();
                    return null;
                }

            case BOOLEAN:
                return in.nextBoolean();

            case NULL:
                in.nextNull();
                return null;

            default:
                throw new IllegalStateException();
        }

    }

    @Override
    public void write(JsonWriter out, Object value) throws IOException {
        // 序列化无需实现
    }
}
