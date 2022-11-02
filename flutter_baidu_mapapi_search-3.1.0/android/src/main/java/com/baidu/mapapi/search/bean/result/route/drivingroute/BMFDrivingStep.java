package com.baidu.mapapi.search.bean.result.route.drivingroute;

import java.util.ArrayList;
import java.util.List;

import com.baidu.mapapi.model.LatLng;
import com.baidu.mapapi.search.bean.result.route.BMFRouteNode;
import com.baidu.mapapi.search.bean.result.route.BMFStep;
import com.baidu.mapapi.search.route.DrivingRouteLine;

public class BMFDrivingStep extends BMFStep {
    /**
     * 该路段起点方向值
     */
    int direction;

    /**
     * 路段入口信息
     */
    BMFRouteNode entrace;

    /**
     * 路段入口的指示信息
     */
    String entraceInstruction;

    /**
     * 路段出口信息
     */
    BMFRouteNode exit;

    /**
     * 路段出口指示信息
     */
    String exitInstruction;

    /**
     * 路段总体指示信息
     */
    String instruction;

    /**
     * 路段需要转弯数
     */
    int numTurns;

    /**
     * 路段是否有路况信息
     */
    boolean hasTrafficsInfo = false;

    /**
     * 路段的路况信息，成员为NSNumber。0：无数据；1：畅通；2：缓慢；3：拥堵
     */
    List<Integer> traffics = new ArrayList<>();

    /**
     * 道路类型
     * 枚举值：返回0-9之间的值
     * 0：高速路  1：城市高速路  2:   国道  3：省道   4：县道    5：乡镇村道
     * 6：其他道路  7：九级路  8：航线(轮渡)  9：行人道路
     */
    int roadLevel;

    /**
     * 道路名称
     * @param drivingStep
     */
    String roadName;

    public BMFDrivingStep(DrivingRouteLine.DrivingStep drivingStep) {
        super(drivingStep);
        if (null == drivingStep) {
            return;
        }

        this.direction = drivingStep.getDirection();
        this.entrace = new BMFRouteNode(drivingStep.getEntrance());
        this.entraceInstruction = drivingStep.getEntranceInstructions();
        this.exit = new BMFRouteNode(drivingStep.getExit());
        this.exitInstruction = drivingStep.getExitInstructions();
        this.roadLevel = drivingStep.getRoadLevel();
        this.instruction = drivingStep.getInstructions();
        this.numTurns = drivingStep.getNumTurns();
        this.roadName = drivingStep.getRoadName();

        int[] traffics = drivingStep.getTrafficList();
        if (null != traffics && traffics.length > 0) {

            for (int i = 0; i < traffics.length; i++) {
                this.traffics.add(traffics[i]);
            }
        }

        if (this.traffics.size() > 0) {
            this.hasTrafficsInfo = true;
        }
    }
}
