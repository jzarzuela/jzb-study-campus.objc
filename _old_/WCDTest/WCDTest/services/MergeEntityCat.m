//
//  MergeEntityCat.m
//  CDTest
//
//  Created by jzarzuela on 06/02/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "MergeEntityCat.h"



//*********************************************************************************************************************
//---------------------------------------------------------------------------------------------------------------------
@implementation TBaseEntity (MergeTBaseEntityCat)


//---------------------------------------------------------------------------------------------------------------------
- (void) mergeFrom:(TBaseEntity *) other withConflit:(BOOL) thereWasConflit {
    
    self.GID = other.GID;
    self.syncETag = other.syncETag;
    self.name = other.name;
    self.desc = other.desc;
    self.wasDeleted = other.wasDeleted;
    self.changed = other.changed;
    self.iconURL = other.iconURL;
    self.ts_created = other.ts_created;
    self.ts_updated = other.ts_updated;
    self.syncStatus = other.syncStatus;
}


@end




//*********************************************************************************************************************
//---------------------------------------------------------------------------------------------------------------------
@implementation TPoint (MergeTPointCat)


//---------------------------------------------------------------------------------------------------------------------
// Copia SOLO los datos. NO las categorias. Se sincroniza de "abajo" (puntos) hacia "arriba" (cats)
- (void) mergeFrom:(TPoint *) other withConflit:(BOOL) thereWasConflit {

    [super mergeFrom:other withConflit:thereWasConflit];

    self.lat = other.lat;
    self.lng = other.lng;
}

@end


//*********************************************************************************************************************
//---------------------------------------------------------------------------------------------------------------------
@implementation TCategory (MergeTCategoryCat)


//---------------------------------------------------------------------------------------------------------------------
// Copia los datos, los puntos y las subcategorias, pero NO HACIA "arriba". Eso su cat "padre"
- (void) mergeFrom:(TCategory *) other withConflit:(BOOL) thereWasConflit {
    
    [super mergeFrom:other withConflit:thereWasConflit];
    
    TMap *myMap = self.map;
  
    
    // Se copia los puntos que categoriza desde la otra.
    // El que borre los suyos o no, depende de si estan en conflicto. En cuyo caso se queda con todos
    // Si un punto o subcategoria se ha borrado en una iteraciÛn de merge previa, habr· borrado su enlace
    // NOTA 1: Cualquier punto que se intente enlazar, por el orden del "merge" deber· existir previamente
    // NOTA 2: Si no se borra mi contenido, puede que algun punto ya este enlazado y NO debe quedar DOBLE
    if(!thereWasConflit) {
        [self removeAllPoints];
    }
    
    // Itero los puntos de la otra categoria
    for(TPoint *point in other.points) {     
        // si no lo tengo lo añado
        TPoint *myPoint = [self pointByGID:point.GID];
        if (myPoint == nil) {
            // Siempre que exista previamente en mi mapa porque primero se deberian haber procesado los puntos
            myPoint = [myMap pointByGID:point.GID];
            if (myPoint != nil) {
                [self addPoint: myPoint];
            }
        }
    }
    
    // Lo mismo que antes con las subcategorias
    if(!thereWasConflit) {
        [self removeAllSubcategories];
    }

    // Itero las subcategorias de la otra categoria
    for(TCategory *scat in other.subcategories) {
        // si no la tengo lo añado
        TCategory *mySCat = [self subcategoryByGID:scat.GID];
        if (mySCat == nil) {
            // Siempre que exista en mi mapa
            mySCat = [myMap categoryByGID:scat.GID];
            if (mySCat != nil) {
                [self addSubcategory:mySCat];
            }
        }
    }
    
}

@end


//*********************************************************************************************************************
//---------------------------------------------------------------------------------------------------------------------
@implementation TMap (MergeTMapCat)


//---------------------------------------------------------------------------------------------------------------------
- (void) mergeFrom:(TMap *) other withConflit:(BOOL) thereWasConflit {
    
    [super mergeFrom:other withConflit:thereWasConflit];
    
}


@end
