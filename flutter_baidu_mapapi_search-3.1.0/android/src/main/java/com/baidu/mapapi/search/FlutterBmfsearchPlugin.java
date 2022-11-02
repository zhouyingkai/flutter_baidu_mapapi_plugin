package com.baidu.mapapi.search;

import androidx.annotation.NonNull;

import com.baidu.mapapi.search.handlers.HandlersFactory;

import io.flutter.embedding.engine.plugins.FlutterPlugin;
import io.flutter.plugin.common.BinaryMessenger;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;
import io.flutter.plugin.common.PluginRegistry.Registrar;

/** FlutterBmfsearchPlugin */
public class FlutterBmfsearchPlugin implements FlutterPlugin, MethodCallHandler {

    @Override
    public void onAttachedToEngine(@NonNull FlutterPluginBinding flutterPluginBinding) {
        if (null == flutterPluginBinding) {
            return;
        }
        initMethodChannel(flutterPluginBinding.getBinaryMessenger());
    }

    public static void registerWith(Registrar registrar) {
        if (null == registrar) {
            return;
        }
        initStaticMethodChannel(registrar.messenger());
    }

    private void initMethodChannel(BinaryMessenger binaryMessenger) {
        if (null == binaryMessenger) {
            return;
        }

        MethodChannel searchChannel = new MethodChannel(binaryMessenger, Constants.MethodChannelName.SEARCH_CHANNEL);
        searchChannel.setMethodCallHandler(this);
        MethodChannelManager.getInstance().putSearchChannel(searchChannel);
    }

    private static void initStaticMethodChannel(BinaryMessenger binaryMessenger) {
        if (null == binaryMessenger) {
            return;
        }

        FlutterBmfsearchPlugin flutterBmfsearchPlugin = new FlutterBmfsearchPlugin();


        MethodChannel searchChannel = new MethodChannel(binaryMessenger, Constants.MethodChannelName.SEARCH_CHANNEL);
        searchChannel.setMethodCallHandler(flutterBmfsearchPlugin);
        MethodChannelManager.getInstance().putSearchChannel(searchChannel);
    }

    @Override
    public void onMethodCall(@NonNull MethodCall call, @NonNull Result result) {
        HandlersFactory.getInstance().dispatchMethodHandler(call, result);
    }

    @Override
    public void onDetachedFromEngine(@NonNull FlutterPluginBinding binding) {
        HandlersFactory.getInstance().destroy();
    }
}
