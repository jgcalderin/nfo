package com.sepe.nfo.components;

import com.documentum.web.common.ArgumentList;
import com.documentum.web.form.control.Radio;

public class AdvSearchEx extends com.documentum.webtop.webcomponent.advsearch.AdvSearchEx 
{

	private static final long serialVersionUID = 1L;

	@Override
	public void onInit(ArgumentList arg0) 
	{
		arg0.add("folderpath","/NFO");
	
        //TODO: ESTO NO FUNCIONA, NI CON EL INIT ANTES NI DESPUÉS
		Radio radioCurrentLocation = getRadioCurrentLocation();
        Radio radioSpecificLocation = getRadioSpecificLocation();
        radioSpecificLocation.setValue(false);
        radioSpecificLocation.setEnabled(false);
        radioCurrentLocation.setValue(true);

		super.onInit(arg0);

	}	
	
    protected void initLocations()
    {
        super.initLocations();
        
        //TODO: ESTO NO FUNCIONA
        Radio radioCurrentLocation = getRadioCurrentLocation();
        Radio radioSpecificLocation = getRadioSpecificLocation();
        radioSpecificLocation.setValue(false);
        radioSpecificLocation.setEnabled(false);
        radioCurrentLocation.setValue(true);

    }
}
