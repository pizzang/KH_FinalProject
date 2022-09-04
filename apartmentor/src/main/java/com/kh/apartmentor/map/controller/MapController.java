package com.kh.apartmentor.map.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class MapController {
	
	@RequestMapping("map.api")
	public String map() {
		return "map/map";
	}

}
