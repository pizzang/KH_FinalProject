package com.kh.apartmentor.map.controller;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;
import java.util.Locale;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
public class BusAPIController {
	
	@ResponseBody
	@RequestMapping(value = "bus640.api", method = RequestMethod.GET, produces = "application/text; charset=utf8")
	public String bus640(Locale locale, Model model) throws IOException{

		StringBuilder urlBuilder = new StringBuilder("http://ws.bus.go.kr/api/rest/buspos/getLowBusPosByRtid"); 
		urlBuilder.append("?" + URLEncoder.encode("ServiceKey","UTF-8") + "=3vbFSNBucTjUmlz76x3t%2FXHUxbPw4FBSuJfqY2xhH5n6sriEAxlGGP%2Fdqlhf2FiOxzA4PbMcX7GpGC%2FowflUrQ%3D%3D"); 
		urlBuilder.append("&" + URLEncoder.encode("busRouteId","UTF-8") + "=" + URLEncoder.encode("100100093", "UTF-8")); 
		URL url = new URL(urlBuilder.toString());
		
		HttpURLConnection conn = (HttpURLConnection) url.openConnection();
		conn.setRequestMethod("GET");
		conn.setRequestProperty("Content-type", "application/xml;charset=UTF-8");
		BufferedReader rd;

		if(conn.getResponseCode() >= 200 && conn.getResponseCode() <= 300) {
			rd = new BufferedReader(new InputStreamReader(conn.getInputStream()));
		} else {
			rd = new BufferedReader(new InputStreamReader(conn.getErrorStream()));
		}

		StringBuilder sb = new StringBuilder();
		String line;

		while ((line = rd.readLine()) != null) {
			sb.append(line);
		}
		
		rd.close();
		conn.disconnect();		

		return sb.toString();			

	}
	
	@ResponseBody
	@RequestMapping(value = "bus6628.api", method = RequestMethod.GET, produces = "application/text; charset=utf8")
	public String bus6628(Locale locale, Model model) throws IOException{

		StringBuilder urlBuilder = new StringBuilder("http://ws.bus.go.kr/api/rest/buspos/getLowBusPosByRtid"); 
		urlBuilder.append("?" + URLEncoder.encode("ServiceKey","UTF-8") + "=3vbFSNBucTjUmlz76x3t%2FXHUxbPw4FBSuJfqY2xhH5n6sriEAxlGGP%2Fdqlhf2FiOxzA4PbMcX7GpGC%2FowflUrQ%3D%3D"); 
		urlBuilder.append("&" + URLEncoder.encode("busRouteId","UTF-8") + "=" + URLEncoder.encode("100100305", "UTF-8")); 
		URL url = new URL(urlBuilder.toString());
		
		HttpURLConnection conn = (HttpURLConnection) url.openConnection();
		conn.setRequestMethod("GET");
		conn.setRequestProperty("Content-type", "application/xml;charset=UTF-8");
		BufferedReader rd;

		if(conn.getResponseCode() >= 200 && conn.getResponseCode() <= 300) {
			rd = new BufferedReader(new InputStreamReader(conn.getInputStream()));
		} else {
			rd = new BufferedReader(new InputStreamReader(conn.getErrorStream()));
		}

		StringBuilder sb = new StringBuilder();
		String line;

		while ((line = rd.readLine()) != null) {
			sb.append(line);
		}
		
		rd.close();
		conn.disconnect();		

		return sb.toString();			

	}

}
