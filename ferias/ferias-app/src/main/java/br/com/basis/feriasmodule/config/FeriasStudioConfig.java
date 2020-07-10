package br.com.basis.feriasmodule.config;

import org.opensingular.lib.wicket.util.resource.DefaultIcons;
import org.opensingular.studio.core.config.StudioConfig;
import org.opensingular.studio.core.menu.StudioMenu;


public class FeriasStudioConfig implements StudioConfig {

    @Override
    public StudioMenu getAppMenu() {
        return StudioMenu.Builder.newPortalMenu()
            .addHTTPEndpoint(DefaultIcons.GLOBE, "Requerimento", "/requirement")
            .addHTTPEndpoint(DefaultIcons.COMMENT, "Análise", "/worklist")
            .getStudioMenu();
    }

}
